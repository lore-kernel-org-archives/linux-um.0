Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzcNS-0005bn-2F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 08:11:10 -0800
Received: from [205.233.219.253] (helo=conifer.conscoop.ottawa.on.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzcNI-0001P4-QI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 08:11:10 -0800
From: Jody McIntyre <scjody@modernduck.com>
Subject: Re: [uml-devel] [PATCH] the xterm that is produced for the virtual
	consoles should have the --name
Message-ID: <20060119161000.GK21325@conscoop.ottawa.on.ca>
References: <18976.1137618090@sandelman.ottawa.on.ca>
	<200601190047.00297.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601190047.00297.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 11:10:00 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Michael Richardson <mcr@xelerance.com>, Jeff Dike <jdike@addtoit.com>

On Thu, Jan 19, 2006 at 12:46:59AM +0100, Blaisorblade wrote:

> --name, with 2 dashes, not 1. Did you test the patch? (It seems perfectly ok 
> for everything else). Fix this, run it and do the below proto update, and for 
> me it's perfectly ok to send.

I tested it with xterm.  Works great!  Unfortunately, I don't have
gnome-terminal and UML working on the same machine.

Cheers,
Jody

> 
> >  static char *exec_switch = "-e";
> >
> >  static int __init xterm_setup(char *line, int *add)
> > @@ -67,6 +68,11 @@ static int __init xterm_setup(char *line
> >  	*line++ = '\0';
> >  	if(*line) exec_switch = line;
> >
> > +	line = strchr(line, ',');
> > +	if(line == NULL) return(0);
> > +	*line++ = '\0';
> > +	if(*line) name_switch = line;
> > +
> >  	return(0);
> >  }
> >
> > @@ -79,8 +85,8 @@ __uml_setup("xterm=", xterm_setup,
> >  "    respectively.  The title switch must have the form '<switch>
> > title',\n" "    not '<switch>=title'.  Similarly, the exec switch must have
> > the form\n" "    '<switch> command arg1 arg2 ...'.\n"
> > -"    The default values are 'xterm=xterm,-T,-e'.  Values for
> > gnome-terminal\n" -"    are 'xterm=gnome-terminal,-t,-x'.\n\n"
> > +"    The default values are 'xterm=xterm,-T,-e,--name'.  Values for
> > gnome-terminal\n" +"    are
> > 'xterm=gnome-terminal,-t,-x,--window-with-profile'.\n\n" );
> >
> >  /* XXX This badly needs some cleaning up in the error paths
> > @@ -93,12 +99,17 @@ int xterm_open(int input, int output, in
> >  	unsigned long stack;
> >  	int pid, fd, new, err;
> >  	char title[256], file[] = "/tmp/xterm-pipeXXXXXX";
> > -	char *argv[] = { terminal_emulator, title_switch, title, exec_switch,
> > -			 "/usr/lib/uml/port-helper", "-uml-socket",
> > +	char umlname[64];
> > +	char *argv[] = { terminal_emulator, title_switch, title,
> > +			 name_switch, umlname,
> > +			 exec_switch,"/usr/lib/uml/port-helper", "-uml-socket",
> >  			 file, NULL };
> >
> > -	if(os_access(argv[4], OS_ACC_X_OK) < 0)
> > -		argv[4] = "port-helper";
> > +	/* get the UML name */
> > +	strcpy(umlname, get_umid(0));
> 
> The prototype just became:
> 
> extern char *get_umid(void);
> 
> > +	if(os_access(argv[6], OS_ACC_X_OK) < 0)
> > +		argv[6] = "port-helper";
> 
> > 0.99.9.GIT
> 
> Update that GIT ;-)
> -- 
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
> http://www.user-mode-linux.org/~blaisorblade
> 
> 
> 
> 
> 
> ___________________________________
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> http://mail.yahoo.it

-- 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
