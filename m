Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRuAz-0003Cv-MD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 09:51:13 -0700
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]
	helo=aa004msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FRuAx-0001hn-5F
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 09:51:13 -0700
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
Message-ID: <20060407165205.GE23715@inferi.kami.home>
References: <20060402173445.GB5108@inferi.kami.home>
	<200604040239.45495.blaisorblade@yahoo.it>
	<20060405211153.GE8583@inferi.kami.home>
	<200604070845.39534.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <200604070845.39534.blaisorblade@yahoo.it>
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
Date: Fri, 7 Apr 2006 18:52:05 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2006 at 08:45:38AM +0200, Blaisorblade wrote:
> On Wednesday 05 April 2006 23:11, Mattia Dongili wrote:
> > On Tue, Apr 04, 2006 at 02:39:44AM +0200, Blaisorblade wrote:
[...]
> > > #define UML_LIB_PATH ":/usr/lib/uml"
> 
> > what about a config option instead? CONFIG_UML_NET_PATH
> 
> Don't think so, that's not supposed to be changed according to any config 
> option or I can't see that. Unless on 64-bit system that's /usr/lib64/uml, 
> and in that case it makes sense to have CONFIG_XXX = 
> "/usr/lib/uml" (without :, add them only in the source, i.e. insulate details 
> away).

Yes, that was what I meant. However it's probably not worth the effort
yet.

> > > 19 -> strlen(UML_LIB_PATH)
> > > in snprintf, "PATH=%s:/usr/lib/uml" -> "PATH=%s" UML_LIB_PATH
> > >
> > > (using string literal concatenation)
> 
> > here's an updated patch, I added a check for current PATH=="" to avoid
> > touching the PATH variable when empty (again, kind of keeping the same
> > behaviour of a clean execvp, I mean it makes no sense to append
> > /usr/lib/uml and not /bin:/usr/bin too).
> 
> In that case, you should append both IMHO - empty PATH and no PATH should be 
> treated the same way, I think.

updated patch attached, I hope you like the if-statement .

Description:
append /usr/lib/uml to the existing PATH environment variable to let
execvp search uml_net in FHS compliant locations.

Signed-off-by: Mattia Dongili <malattia@linux.it>
-- 
mattia
:wq!

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml_net-2.diff"

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

--5I6of5zJg18YgZEa--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
