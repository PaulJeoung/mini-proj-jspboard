package member;

public class LoginResult {
	private boolean success;
    private boolean idValid;
    private boolean pwdValid;

    public LoginResult(boolean success, boolean idValid, boolean pwdValid) {
        this.success = success;
        this.idValid = idValid;
        this.pwdValid = pwdValid;
    }

    public boolean isSuccess() {
        return success;
    }

    public boolean isIdValid() {
        return idValid;
    }

    public boolean isPwdValid() {
        return pwdValid;
    }
}
