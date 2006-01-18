Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzKSH-0001PH-9K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 13:02:57 -0800
Received: from cod.sandelman.ca ([192.139.46.139] helo=lists.sandelman.ca)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1EzKSF-0007Wh-2V
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 13:02:57 -0800
From: Michael Richardson <mcr@xelerance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Message-ID: <18976.1137618090@sandelman.ottawa.on.ca>
Subject: [uml-devel] [PATCH] the xterm that is produced for the virtual
	consoles should have the --name
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
Date: Wed, 18 Jan 2006 16:01:30 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Jody McIntyre <scjody@modernduck.com>

--=-=-=


From: Michael Richardson <mcr@xelerance.com>

the xterm that is produced for the virtual consoles should have the
--name option added. This will tell the xterm to lookup a custom resource in
the X resource database, and may permit the user to have all the consoles
associated with a given UML be the same colour. For instance, you could
put:
	marajade-[~] mcr 1129 %grep east .Xresources
	east*foreground: Green
	east*background: Black
	east*saveLines: 1000

this patch added a fourth argument to the xterm definition so that the
name of the option could be changed. For gnome-terminal, perhaps
--window-with-profile will work. It looks like this option will work without
the = in the option, so it should work for gnome people too.

---

 arch/um/drivers/xterm.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

applies-to: f0f578967fc649a7b993b212e164b658639ef184
7335417358836aebdb201c5e2ea6229af6449af6
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index aaa6366..0220d59 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -50,6 +50,7 @@ void *xterm_init(char *str, int device, 
 /* Only changed by xterm_setup, which is a setup */
 static char *terminal_emulator = "xterm";
 static char *title_switch = "-T";
+static char *name_switch = "-name";
 static char *exec_switch = "-e";
 
 static int __init xterm_setup(char *line, int *add)
@@ -67,6 +68,11 @@ static int __init xterm_setup(char *line
 	*line++ = '\0';
 	if(*line) exec_switch = line;
 
+	line = strchr(line, ',');
+	if(line == NULL) return(0);
+	*line++ = '\0';
+	if(*line) name_switch = line;
+
 	return(0);
 }
 
@@ -79,8 +85,8 @@ __uml_setup("xterm=", xterm_setup,
 "    respectively.  The title switch must have the form '<switch> title',\n"
 "    not '<switch>=title'.  Similarly, the exec switch must have the form\n"
 "    '<switch> command arg1 arg2 ...'.\n"
-"    The default values are 'xterm=xterm,-T,-e'.  Values for gnome-terminal\n"
-"    are 'xterm=gnome-terminal,-t,-x'.\n\n"
+"    The default values are 'xterm=xterm,-T,-e,--name'.  Values for gnome-terminal\n"
+"    are 'xterm=gnome-terminal,-t,-x,--window-with-profile'.\n\n"
 );
 
 /* XXX This badly needs some cleaning up in the error paths
@@ -93,12 +99,17 @@ int xterm_open(int input, int output, in
 	unsigned long stack;
 	int pid, fd, new, err;
 	char title[256], file[] = "/tmp/xterm-pipeXXXXXX";
-	char *argv[] = { terminal_emulator, title_switch, title, exec_switch, 
-			 "/usr/lib/uml/port-helper", "-uml-socket",
+	char umlname[64];
+	char *argv[] = { terminal_emulator, title_switch, title,
+			 name_switch, umlname,
+			 exec_switch,"/usr/lib/uml/port-helper", "-uml-socket",
 			 file, NULL };
 
-	if(os_access(argv[4], OS_ACC_X_OK) < 0)
-		argv[4] = "port-helper";
+	/* get the UML name */
+	strcpy(umlname, get_umid(0));
+
+	if(os_access(argv[6], OS_ACC_X_OK) < 0)
+		argv[6] = "port-helper";
 
 	/* Check that DISPLAY is set, this doesn't guarantee the xterm
 	 * will work but w/o it we can be pretty sure it won't. */
---
0.99.9.GIT



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQ86sqoCLcPvd0N1lAQKjVAf+IPkvNbGH0eailRq7NjJPW4wT/BDBj+qa
bONMbUlpO+3q71oW7Fn81R0YwJ4kkUPVgikuyiO6ZczR60zntrj4NQk2CSPDOQDB
VWSPkuaafDGIWkbJRHeN65xudfa6HV+n8SeBbE458C/yN4AxyKfH5XtYMa5nKxyC
fBsgSS6Af9WFqGEmedVaPbW1T+Ha9ooX61ND7qClgvZEiZsY2bnfVzt8Eh0ZltdK
aI3AbgeayRw+IaakGNamEY93J97TePH63EiR9g58w4HPWmzPeQS1evBghFWk6MF7
Q2DQcErvijSQ8Gu1FPT7ppSOkmADQ8a8U+H5RyrZCa4gMiKuyPBWLg==
=4zKR
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
