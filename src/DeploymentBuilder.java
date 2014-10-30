
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import com.amazonaws.auth.*;
import com.amazonaws.services.s3.*;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.amazonaws.services.elasticbeanstalk.*;
import com.amazonaws.services.elasticbeanstalk.model.*;

public class DeploymentBuilder {

	public static void main(String[] args) {

		// Check existing version and check if environment is production
		int checkExistingAppVersion, prodEnviroment, war;
		AWSCredentials credentials = null;
		try {
			credentials = new PropertiesCredentials(
					DeploymentBuilder.class
							.getResourceAsStream("AwsCredentials.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		AmazonS3 s3 = new AmazonS3Client(credentials);
		AWSElasticBeanstalk elasticBeanstalk = new AWSElasticBeanstalkClient(
				credentials);

		File warFile = new File("TwitMap-1.war");
		String bucketName = elasticBeanstalk.createStorageLocation()
				.getS3Bucket();
		String key;
		try {
			key = URLEncoder.encode("TwitMap-1.war", "UTF-8");

			PutObjectResult s3Result = s3.putObject(bucketName, key, warFile);
			List<ApplicationDescription> desc = elasticBeanstalk
					.describeApplications().getApplications();
			String appname = "applicationName", version = "7.0";
			boolean appthere = false;

			for (ApplicationDescription ad : desc)
				if (ad.getApplicationName().equals(appname))
					appthere = true;
			if (!appthere) {

				CreateApplicationRequest createApplicationRequest = new CreateApplicationRequest(
						"applicationName");

				CreateApplicationResult createApplicationResult = elasticBeanstalk
						.createApplication(createApplicationRequest);

				System.out.println("Registered application version "
						+ createApplicationResult.getApplication());
			}

			CreateApplicationVersionRequest createApplicationvRequest = new CreateApplicationVersionRequest(
					appname, version);
			createApplicationvRequest.setSourceBundle(new S3Location(
					bucketName, key));
			CreateApplicationVersionResult createApplicationVersionResult = elasticBeanstalk
					.createApplicationVersion(createApplicationvRequest);
			System.out.println("Registered application version "
					+ createApplicationVersionResult.getApplicationVersion());

			System.out
					.println("Update environment with uploaded application version");

			CreateEnvironmentRequest env_create = new CreateEnvironmentRequest(
					"applicationName", "environmentName3");
			env_create
					.setSolutionStackName("64bit Amazon Linux running Tomcat 6");
			env_create.setDescription("envname");

			EnvironmentTier et = new EnvironmentTier();
			et.setName("WebServer");
			et.setType("standard");
			et.setVersion("2.0");
			// env_create.setTier(et);
			CreateEnvironmentResult env_res = elasticBeanstalk
					.createEnvironment(env_create);
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		}
	}

}
