Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LfDH2-0002pA-Et
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 13:06:04 +0000
Received: from ti-out-0910.google.com ([209.85.142.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LfDGz-0006Iw-CW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 13:06:04 +0000
Received: by ti-out-0910.google.com with SMTP id a6so3886261tib.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 05 Mar 2009 05:05:58 -0800 (PST)
Date: Thu, 5 Mar 2009 21:06:10 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090305130610.GA4265@hack.private>
References: <49AFC206.9080004@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49AFC206.9080004@panasas.com>
Subject: Re: [uml-devel] um: WARNING: vmlinux: 'memcpy' exported twice.
	Previous export	was in vmlinux
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Mar 05, 2009 at 02:13:58PM +0200, Boaz Harrosh wrote:
>On today's linus v2.6.29-rc7-3-g559595a
>
>Doing make ARCH=um defconfig & make ARCH=um
>give's me:
>
>LD vmlinux.o
>MODPOST vmlinux.o
>WARNING: vmlinux: 'memcpy' exported twice. Previous export was in vmlinux
>
>
>Sorry if this is a duplicate report
>

Weird...
I tried to compile like what you said, I can't reproduce it.

Which gcc are you using?

Thanks.

-- 
Do what you love, f**k the rest! F**k the regulations!
 

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

