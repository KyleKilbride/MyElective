package beans;

/**
* A class for User objects. 
* Contains setters and getters for all fields
*
* @author Matthew Boyd
* @version 0.1 
*/

public class User  {
	
	/** The Users usernmae */
	private String username;
	/** The Users password */
	private String password;
	/** The Users first name */
	private String firstName;
	/** The Users last name */
	private String lastName;
	/** The Users email address */
	private String emailAddress;
	/** The users program of study */
	private String program;
	/** The Users type (admin or user) */
	private String status;
	
	/**
	 * Default Constructor
	 */
	public User(){
		
	}

	/**
	 * Getter for the USers username
	 * @return Users username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Setter for the Users username
	 * @param username
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * Getter for the Users password
	 * @return Users password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Setter for the Users password
	 * @param password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * Getter for the Users first name
	 * @return	Users first name
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Setter for the Users first name
	 * @param firstName
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * Getter for the Users last name
	 * @return	Users last name
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Setter for the Users last name
	 * @param lastName
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * Getter for the Users email
	 * @return	Users email
	 */
	public String getEmailAddress() {
		return emailAddress;
	}

	/**
	 * Setter for the Users email
	 * @param emailAddress
	 */
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	/**
	 * Getter for the Users program of study
	 * @return	Users program
	 */
	public String getProgram() {
		return program;
	}

	/**
	 * Setter for the Users program of study
	 * @param program
	 */
	public void setProgram(String program) {
		this.program = program;
	}

	/**
	 * Getter for Users status
	 * @return	Users status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Setter for Users status
	 * @param status
	 */
	public void setStatus(String status) {
		this.status = status;
	}

}
