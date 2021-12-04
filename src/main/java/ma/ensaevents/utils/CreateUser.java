package ma.ensaevents.utils;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import ma.ensaevents.validation.FieldMatch;
import ma.ensaevents.validation.ValidEmail;



@FieldMatch.List({
    @FieldMatch(first = "password", second = "matchingPassword", message = "The password fields must match")
})

public class CreateUser {

	@NotNull(message = "A username is required")
	@Size(min = 1, message = "A username is required")
	private String userName;

	@NotNull(message = "A password is required")
	@Size(min = 1, message = "A password is required")
	private String password;

	private String matchingPassword;

	@NotNull(message = "First name is required")
	@Size(min = 1, message = "First name is required")
	private String firstName;

	@NotNull(message = "Last name is required")
	@Size(min = 1, message = "Last name is required")
	private String lastName;

	@ValidEmail
	@NotNull(message = "Email is required")
	@Size(min = 1, message = "Email is required")
	private String email;
	
	public CreateUser() {

	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMatchingPassword() {
		return matchingPassword;
	}

	public void setMatchingPassword(String matchingPassword) {
		this.matchingPassword = matchingPassword;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
