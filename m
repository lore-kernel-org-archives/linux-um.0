Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzN18-0000TA-VP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:47:06 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzN15-0002bn-Mt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:47:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] the xterm that is produced for the virtual
	consoles should have the --name
References: <18976.1137618090@sandelman.ottawa.on.ca>
In-Reply-To: <18976.1137618090@sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200601190047.00297.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 00:46:59 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@xelerance.com>, Jeff Dike <jdike@addtoit.com>, Jody McIntyre <scjody@modernduck.com>

On Wednesday 18 January 2006 22:01, Michael Richardson wrote:
> From: Michael Richardson <mcr@xelerance.com>

> the xterm that is produced for the virtual consoles should have the
> --name option added. This will tell the xterm to lookup a custom resource
> in the X resource database, and may permit the user to have all the
> consoles associated with a given UML be the same colour. For instance, you
> could put:

> 	marajade-[~] mcr 1129 %grep east .Xresources
> 	east*foreground: Green
> 	east*background: Black
> 	east*saveLines: 1000

From the patch I guess that's for umid=east, right?

I believe to every single word of what you say, but this is black magic to 
me... I'm too young for this sort of things :-)

> this patch added a fourth argument to the xterm definition so that the
> name of the option could be changed. For gnome-terminal, perhaps
> --window-with-profile will work. It looks like this option will work
> without the = in the option, so it should work for gnome people too.

If needing the =, they can pass it in I guess (well, we should check the 
option parser, guess it's happy).

>  static char *title_switch = "-T";
> +static char *name_switch = "-name";

--name, with 2 dashes, not 1. Did you test the patch? (It seems perfectly ok 
for everything else). Fix this, run it and do the below proto update, and for 
me it's perfectly ok to send.

>  static char *exec_switch = "-e";
>
>  static int __init xterm_setup(char *line, int *add)
> @@ -67,6 +68,11 @@ static int __init xterm_setup(char *line
>  	*line++ = '\0';
>  	if(*line) exec_switch = line;
>
> +	line = strchr(line, ',');
> +	if(line == NULL) return(0);
> +	*line++ = '\0';
> +	if(*line) name_switch = line;
> +
>  	return(0);
>  }
>
> @@ -79,8 +85,8 @@ __uml_setup("xterm=", xterm_setup,
>  "    respectively.  The title switch must have the form '<switch>
> title',\n" "    not '<switch>=title'.  Similarly, the exec switch must have
> the form\n" "    '<switch> command arg1 arg2 ...'.\n"
> -"    The default values are 'xterm=xterm,-T,-e'.  Values for
> gnome-terminal\n" -"    are 'xterm=gnome-terminal,-t,-x'.\n\n"
> +"    The default values are 'xterm=xterm,-T,-e,--name'.  Values for
> gnome-terminal\n" +"    are
> 'xterm=gnome-terminal,-t,-x,--window-with-profile'.\n\n" );
>
>  /* XXX This badly needs some cleaning up in the error paths
> @@ -93,12 +99,17 @@ int xterm_open(int input, int output, in
>  	unsigned long stack;
>  	int pid, fd, new, err;
>  	char title[256], file[] = "/tmp/xterm-pipeXXXXXX";
> -	char *argv[] = { terminal_emulator, title_switch, title, exec_switch,
> -			 "/usr/lib/uml/port-helper", "-uml-socket",
> +	char umlname[64];
> +	char *argv[] = { terminal_emulator, title_switch, title,
> +			 name_switch, umlname,
> +			 exec_switch,"/usr/lib/uml/port-helper", "-uml-socket",
>  			 file, NULL };
>
> -	if(os_access(argv[4], OS_ACC_X_OK) < 0)
> -		argv[4] = "port-helper";
> +	/* get the UML name */
> +	strcpy(umlname, get_umid(0));

The prototype just became:

extern char *get_umid(void);

> +	if(os_access(argv[6], OS_ACC_X_OK) < 0)
> +		argv[6] = "port-helper";

> 0.99.9.GIT

Update that GIT ;-)
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
