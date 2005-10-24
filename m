Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUBcM-0007Gg-2T	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 16:20:38 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUBcJ-0004R2-Gp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 16:20:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Unassociated ubd in sysfs?
References: <200510221318.00565.rob@landley.net>
In-Reply-To: <200510221318.00565.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250124.21434.blaisorblade@yahoo.it>
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
Date: Tue, 25 Oct 2005 01:24:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Saturday 22 October 2005 20:18, Rob Landley wrote:
> I'm trying to play with a system that doesn't have any hardwired
> major/minors in it, just an initscript doing "find /sys -name dev", a bit
> of sed work, and mknod.  (Eventually I'll get the full udev up, but for now
> a dumb little shell script works pretty well.)
>
> Unfortunately, it doesn't list any unassociated ubd devices when I do this.
>  I get loop devices, ttys, even /dev/zero and friends, but no ubd.

>  If I 
> associate one with a file from the command line, it shows up in sys,
Ah, ok, sorry for my previous email. Yes, this matches with what I remember. 
And this also makes sense - it's as for hd* - only present devices are shown.
> but I 
> was under the impression I could associate them from "mount" as well..?
Sorry, but __how__? And to _which purpose_?

The only way you have is:
*) ssh/(telnet) to the host
*) uml_mconsole
*) config ubd0=path (path relative to the UML cwdir at startup). Yes, this is 
hotplug. And it also works for network devices. It's as wonderful as it gets.

> I 
> don't have any ubd nodes to associate anything with unless they show up in
> sysfs first...

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
