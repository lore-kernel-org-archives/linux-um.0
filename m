Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-user] Re: [uml-devel] "Configuring network
	interfaces...execvp of 'uml_net' failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX>
	<20060217154425.GA3823@ccure.user-mode-linux.org>
	<200602171948.29509.blaisorblade@yahoo.it>
In-Reply-To: <200602171948.29509.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602191704.03527.rob@landley.net>
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
Date: Sun, 19 Feb 2006 17:04:03 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net

On Friday 17 February 2006 1:48 pm, Blaisorblade wrote:
> On Friday 17 February 2006 16:44, Jeff Dike wrote:
> > On Fri, Feb 17, 2006 at 03:05:28PM +0100, Blaisorblade wrote:
> > > For the future packaging: I do believe that Debian's defaults have been
> > > actually planned while uml_utilities haven't, so I like the idea of
> > > switching to Debian paths as defaults, and possibly using the current
> > > ones as fallbacks.
> >
> > Yup, as long as they are not too Debian-specific.
>
> They tend to make more sense and adhere better to the
> FHS. /var/run/uml-utilities requires support from the distro, but having
> uml_net in /usr/lib is a correct idea, for instance.

I'm confused, why would you have executables in a shared library directory 
instead of /usr/bin or some such?  (These are runnable elf binaries, not 
shared libraries, correct?)

Rob
-- 
Never bet against the cheap plastic solution.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
