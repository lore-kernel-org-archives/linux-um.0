Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQ8da-0001k1-OC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 12:53:26 -0700
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]
	helo=aa005msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FQ8dY-0007lw-Sh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 12:53:26 -0700
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
Message-ID: <20060402195409.GA3695@inferi.kami.home>
References: <20060402173445.GB5108@inferi.kami.home>
	<Pine.LNX.4.62.0604022027190.15153@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0604022027190.15153@pademelon.sonytel.be>
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
Date: Sun, 2 Apr 2006 21:54:09 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 02, 2006 at 08:29:12PM +0200, Geert Uytterhoeven wrote:
> On Sun, 2 Apr 2006, Mattia Dongili wrote:
[...]
> > --- a/arch/um/os-Linux/helper.c	2006-04-02 16:32:38.340801686 +0200
> > +++ b/arch/um/os-Linux/helper.c	2006-04-02 16:34:13.454745936 +0200
> > @@ -22,6 +22,9 @@ struct helper_data {
> >  	int fd;
> >  };
> >  
> > +/* PATH variable to find uml helpers  installed in FHS compliant locations */
> > +static char *alt_path = "PATH=:/bin:/usr/bin:/usr/lib/uml"; 
>                                  ^
> Woops, this puts the current directory first in your path, which is probably

Urgh! that was just the default path straight from the execle manpage.
The attached patch reimplements the thing appending /usr/lib/uml only
once before starting UML. Still using the above PATH if no PATH variable
exists as execle behaves in the same way.

Signed-off-by: Mattia Dongili <malattia@linux.it>
-- 
mattia
:wq!

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml_net.diff"

--- arch/um/os-Linux/main.c~clean	2006-04-02 21:08:26.782461831 +0200
+++ arch/um/os-Linux/main.c	2006-04-02 21:37:45.548377831 +0200
@@ -74,6 +74,31 @@ static void last_ditch_exit(int sig)
 	exit(1);
 }
 
+static void setup_env_path(void) {
+	char *new_path = NULL;
+	char *old_path = NULL;
+	int path_len = 0;
+
+	old_path = getenv("PATH");
+	if (!old_path) {
+		/* if no PATH variable is set, just use 
+		 * the default + /usr/lib/uml
+		 */
+		putenv("PATH=:/bin:/usr/bin/:/usr/lib/uml");
+		return;
+	}
+
+	/* append /usr/lib/uml to the existing path */
+	path_len = strlen(old_path) + 19; 
+	new_path = malloc(path_len * sizeof(char));
+	if (!new_path) {
+		perror("coudn't malloc to set a new PATH");
+		return;
+	}
+	snprintf(new_path, path_len, "PATH=%s:/usr/lib/uml", old_path);
+	putenv(new_path);
+}
+
 extern int uml_exitcode;
 
 extern void scan_elf_aux( char **envp);
@@ -114,6 +139,8 @@ int main(int argc, char **argv, char **e
 
 	set_stklim();
 
+	setup_env_path();
+
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if(new_argv == NULL){
 		perror("Mallocing argv");

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
