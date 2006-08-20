Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GEkUi-0005Z3-7R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Aug 2006 03:25:28 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GEkUg-0004e7-F1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Aug 2006 03:25:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 20 Aug 2006 12:24:50 +0200
References: <200608171256.57196.peter@fusselt.net>
	<200608191653.43641.blaisorblade@yahoo.it>
	<200608191838.51481.peter@fusselt.net>
In-Reply-To: <200608191838.51481.peter@fusselt.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608201224.51029.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Peter Hovorka <peter@fusselt.net>

On Saturday 19 August 2006 18:38, Peter Hovorka wrote:
> Hi,
>
> > > ./um2.6.16.27-bb1 ubd0=root_fs ubd1=swap_fs eth0=tuntap,tap112
> >
> > Do you really mean "tap112"?
>
> Yes, Sir.
I didn't want to be rude, sorry.

> > Nobody I think tried this. > I've checked
> > for bugs in parsing, but there is none. Please give more details and
> > try a saner setting, or elaborate on the reason of this strange
> > setting. At least let's determine if changing it causes the bug not
> > to show up.
>
> I've used taps according to the used IP in a range of 1-254 since 2002 -
> and I've never experienced any problems in doing so. So tap112 is quite
> a sane setting - for me at least it is.

I was just surprised, and one of my thoughts was "it is barfing on 112 because 
maybe the code is stupid and expects 1 digit". So I asked just to make sure.

The other was "why is he doing this? Does he need? Probably yes, I won't take 
that for granted and instead I'll ask him".

> > The other possibility is that something in the guest image (I'm not
> > talking about the kernel, but about the rootfs) is calling ifrename.
> > But since some kernels don't do that, this is probably not the case.

> I have tried this with three more or less different file systems after
> your mail to the list (and I should have done earlier - only thing I
> hadn't thought of), as there are:

> - Ubuntu Server 6.0.6 LTS
> - Fedora Core 5
> - Debian Sarge

> The problem seems to be Ubuntu - FC5 and Debian Sarge do well.
> No 
> problems with them. I would like to use Ubuntu, though - so it would be
> nice to have a workaround or at least the cause for this to happen.

About Ubuntu, make sure ifrename is not installed and /etc/network/if-* 
and /etc/rc2.d do not mention ifrename, and that ifrename is not installed.
I can only think that some hotplug script is receiving an event through 
sysfs / hotplug / some such hell and is renaming the interface.

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
