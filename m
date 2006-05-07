Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FcnYs-0006Nb-IL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 11:00:54 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FcnYp-0003dR-RR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 11:00:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem on generation a locales on uml image
References: <20060505124937.GA4327@SteX> <20060505223816.GB6864@SteX>
	<20060506030333.GA6830@ccure.user-mode-linux.org>
In-Reply-To: <20060506030333.GA6830@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071952.28441.blaisorblade@yahoo.it>
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
Date: Sun, 7 May 2006 19:52:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Stefano Melchior <stefano.melchior@openlabs.it>, user-mode-linux-devel@lists.sourceforge.net, Mattia Dongili <malattia@linux.it>

On Saturday 06 May 2006 05:03, Jeff Dike wrote:
> On Sat, May 06, 2006 at 12:38:16AM +0200, Stefano Melchior wrote:
> > I may understand that my public server (where I also use to play with uml
> > too, from remote, i.e. free time at the office) is a PIII500 with only
> > 128MB of RAM and an old 12GB hdd: this lack of performances and the
> > temporary high cpu load (postfix+spamassassin+apache2+mysql) can be the
> > reason of this problems.
>
> It doesn't seem to have much to do with the capabilities of the host.  I
> can make it happen on an unloaded, fairly capable host.
>
> > May it be reasonable to increase this schedule timeout? I mean moving the
> > limit to 15-20sec?
>
> Or you can just disable it.

Beyond false positives, also true positives exists and somebody hits them; 
ignoring the report if the system doesn't hang is also ok.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
