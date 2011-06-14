Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1QWQ8z-00041m-TV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Jun 2011 09:42:45 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QWQ8z-00030G-0A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Jun 2011 09:42:45 +0000
Received: by wwj40 with SMTP id 40so5072956wwj.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 14 Jun 2011 02:42:38 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Tue, 14 Jun 2011 11:46:54 +0200
References: <201106121314.39884.florian@openwrt.org>
	<201106130145.27424.richard@nod.at>
In-Reply-To: <201106130145.27424.richard@nod.at>
MIME-Version: 1.0
Message-Id: <201106141146.55070.florian@openwrt.org>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/2] um: disable funit-at-a-time for gcc <
	4.3
To: Richard Weinberger <richard@nod.at>
Cc: nico@openwrt.org, user-mode-linux-devel@lists.sourceforge.net

On Monday 13 June 2011 01:45:27 Richard Weinberger wrote:
> Am Sonntag 12 Juni 2011, 13:14:39 schrieb Florian Fainelli:
> > From: Nicolas Thill <nico@openwrt.org>
> > 
> > Building UML with gcc < 4.3 with -funit-at-a-time for i386 causes startup
> > crashes, disabling funit-at-a-time works around it.
> 
> Can you show me such a crash?
> How can I reproduce the issue?

Let me get you a test case to reproduce that issue.

> 
> UML works fine on my RHEL5/i386 test box.
> gcc 4.1.2 20080704 (Red Hat 4.1.2-46)
> 
> Thanks,
> //richard
--
Florian

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

