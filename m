Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcOHN-00011Y-S0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 06:28:53 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EcOHI-0000Fl-Uh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 06:28:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1131140395.27405.6.camel@localhost.localdomain>
	<200511142127.29052.blaisorblade@yahoo.it>
	<1132099022.12792.66.camel@localhost.localdomain>
In-Reply-To: <1132099022.12792.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161537.18451.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: 2.6.14-bs1
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
Date: Wed, 16 Nov 2005 15:37:17 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 16 November 2005 00:57, Antoine Martin wrote:

> skas3 works absolutely  fine.
> The only problem I've got with skas3 is that it requires /proc/mm in
> the chroot and the only way that I found to do this is to mount it in
> there. (SELinux will need some work to allow me to restrict write
> access to just /proc/mm and not the whole /proc...)
For the rest I have no definite answer yet, BUT:

mkdir /chroot/proc
touch /chroot/proc/mm
mount --bind /proc/mm /chroot/proc/mm

is reported to work (and I tested it once). On 2.4 kernels too. Surprise 
surprise :-) !

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
