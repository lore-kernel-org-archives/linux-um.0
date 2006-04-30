Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaCkU-0001i3-6o for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:10 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FaCkP-0001yo-3s for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:05 -0700
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaCkO-0005Z4-4O for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:04 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430141611.9060.59508.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/7] uml: search from uml_net in a more reasonable
	PATH
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 30 Apr 2006 16:16:11 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Mattia Dongili <malattia@linux.it>

Append /usr/lib/uml to the existing PATH environment variable to let
execvp() search uml_net in FHS compliant locations.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/main.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 2878e89..02cf668 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -74,6 +74,33 @@ static void last_ditch_exit(int sig)
 	exit(1);
 }
 
+#define UML_LIB_PATH	":/usr/lib/uml"
+
+static void setup_env_path(void) {
+	char *new_path = NULL;
+	char *old_path = NULL;
+	int path_len = 0;
+
+	old_path = getenv("PATH");
+	/* if no PATH variable is set or it has an empty value
+	 * just use the default + /usr/lib/uml
+	 */
+	if (!old_path || (path_len = strlen(old_path)) == 0) {
+		putenv("PATH=:/bin:/usr/bin/" UML_LIB_PATH);
+		return;
+	}
+
+	/* append /usr/lib/uml to the existing path */
+	path_len += strlen("PATH=" UML_LIB_PATH) + 1;
+	new_path = malloc(path_len);
+	if (!new_path) {
+		perror("coudn't malloc to set a new PATH");
+		return;
+	}
+	snprintf(new_path, path_len, "PATH=%s" UML_LIB_PATH, old_path);
+	putenv(new_path);
+}
+
 extern int uml_exitcode;
 
 extern void scan_elf_aux( char **envp);
@@ -114,6 +141,8 @@ int main(int argc, char **argv, char **e
 
 	set_stklim();
 
+	setup_env_path();
+
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if(new_argv == NULL){
 		perror("Mallocing argv");


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
