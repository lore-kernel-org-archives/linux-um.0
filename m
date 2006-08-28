Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHfow-00054T-9g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 05:02:26 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user78501)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GHfou-00047s-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 05:02:26 -0700
References: <200608171256.57196.peter@fusselt.net>
	<517e86fb0608201103r7f07f57cxc433d1d15d49824b@mail.gmail.com>
	<200608261435.17970.peter@fusselt.net>
	<200608261507.09004.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
Date: Mon, 28 Aug 2006 13:02:07 +0100
In-Reply-To: <200608261507.09004.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sat,
	26 Aug 2006 15:07:08 +0200")
Message-ID: <878xl9qda8.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] Strange behaviour in eth assignments
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Peter Hovorka <peter@fusselt.net>, user-mode-linux-devel@lists.sourceforge.net

On Sat, 26 Aug 2006, blaisorblade@yahoo.it stipulated:
> I'm starting to get sick of udev - on Ubuntu currently I'm unable to compile a 
> vanilla kernel that works (I must still do more complete tests but I'm 
> already beyond the "I've misconfigured something" moment).

All udev needs is CONFIG_HOTPLUG and sysfs, as far as I know.

-- 
`In typical emacs fashion, it is both absurdly ornate and
 still not really what one wanted.' --- jdev

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
