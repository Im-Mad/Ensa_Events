package ma.ensaevents.utils;

import ma.ensaevents.validation.FieldMatch;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


@FieldMatch.List({
    @FieldMatch(first = "password", second = "matchingPassword", message = "The new passwords fields must match")
})

public class ChangePassword {

	@NotNull(message = "A password is required")
	@Size(min = 1, message = "A password is required")
	private String oldPassword;

	@NotNull(message = "A new password is required")
	@Size(min = 1, message = "A new password is required")
	private String password;

	private String matchingPassword;

	public ChangePassword() {
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

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
}
