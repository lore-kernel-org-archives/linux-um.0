Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1VAbUR-0003Vs-0q
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Aug 2013 08:04:03 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VAbUP-0008U7-8H for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Aug 2013 08:04:02 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id C1ED01D1528
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Aug 2013 09:44:02 +0200 (CEST)
MIME-Version: 1.0
Date: Sat, 17 Aug 2013 09:44:02 +0200
From: stian@nixia.no
In-Reply-To: <1376682288-25315-1-git-send-email-richard@nod.at>
References: <1376682288-25315-1-git-send-email-richard@nod.at>
Message-ID: <cae15b5bcee216a9879a11d8a219daba@nixia.no>
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
Subject: Re: [uml-devel] [PATCH] um: Implement probe_kernel_read()
To: user-mode-linux-devel@lists.sourceforge.net

Den 2013-08-16 21:44, skrev Richard Weinberger:
> +long probe_kernel_read(void *dst, const void *src, size_t size)
> +{
> +	void *psrc = (void *)rounddown((u64)src, PAGE_SIZE);
Should not size be increased if psrc is moved down?

Example:
  src  = 0x0ffff; // pointed to the very end of a page
  size = 2;       // big enough to cross two pages

  psrc = 0x0f000; // pointed to the start of the first page
  size = 2;       // does not include the second page anymore

  second page is not checked

Or is this not a problem?

Stian

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

