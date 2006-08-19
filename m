Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GETrA-0007dg-FR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 09:39:32 -0700
Received: from 213-203-244-217.kunde.vdserver.de
	([213.203.244.217] helo=alpha.korypet.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GETr8-0003Ui-RG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 09:39:32 -0700
Received: from p5080ea5b.dip.t-dialin.net ([80.128.234.91]
	helo=bravo.korypet.de)
	by alpha.korypet.com with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1GETr2-0000K8-NH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 16:39:25 +0000
From: Peter Hovorka <peter@fusselt.net>
Date: Sat, 19 Aug 2006 18:38:51 +0200
References: <200608171256.57196.peter@fusselt.net>
	<200608191653.43641.blaisorblade@yahoo.it>
In-Reply-To: <200608191653.43641.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608191838.51481.peter@fusselt.net>
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

Hi,

> > ./um2.6.16.27-bb1 ubd0=root_fs ubd1=swap_fs eth0=tuntap,tap112
>
> Do you really mean "tap112"? 

Yes, Sir.

> Nobody I think tried this. > I've checked  
> for bugs in parsing, but there is none. Please give more details and
> try a saner setting, or elaborate on the reason of this strange
> setting. At least let's determine if changing it causes the bug not
> to show up.

I've used taps according to the used IP in a range of 1-254 since 2002 - 
and I've never experienced any problems in doing so. So tap112 is quite 
a sane setting - for me at least it is.

I have tried other tap settings in a range from tap1-254 (and even 
simple tunctls without assigning a special number) - with the same 
results.

> The other possibility is that something in the guest image (I'm not
> talking about the kernel, but about the rootfs) is calling ifrename.
> But since some kernels don't do that, this is probably not the case.

I have tried this with three more or less different file systems after 
your mail to the list (and I should have done earlier - only thing I 
hadn't thought of), as there are:

- Ubuntu Server 6.0.6 LTS
- Fedora Core 5
- Debian Sarge

The problem seems to be Ubuntu - FC5 and Debian Sarge do well. No 
problems with them. I would like to use Ubuntu, though - so it would be 
nice to have a workaround or at least the cause for this to happen.

> > mem=100M
>
> You'd better use a round amount (128 or 96M), I don't know if that's
> a problem but that's strange.

There has never been a single problem in assigning memory outside the 
'round amount' row. I've assigned thousands of instances with 34, 35, 
36 MB or 67, 68, 69 MB or 130, 131, 132 MB and so on. 

I have tried other memory options after your comment from above, but it 
doesn't change the strange behaviour.

> If this were, say, a buffer overflow, or a bug because tap112 does
> not exist, the source causes "unspecified behaviour", so totally
> unrelated changes can change the actual behaviour to change.

Tap112 did exist, I set them up manually not by the uml_helper. As I 
said, older Kernel versions did not show any problems of this kind. I 
double and triple checked everything I could from a user's perspective 
and it took me several days until I packed my bag to look out for Jeff 
in the #uml and to finally post to uml-devel - the only thing I didn't 
take a closer look at was the file system respectively the distro.

Kind regards,
Peter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
