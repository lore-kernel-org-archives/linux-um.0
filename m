Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFdye-0002nb-FM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 15:17:01 -0800
Received: from mga11.intel.com ([192.55.52.93])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFdye-0000UC-8K
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 15:16:52 -0800
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 17 Jan 2008 15:17:38 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEE62B45A@orsmsx423.amr.corp.intel.com>
In-Reply-To: <20080117230802.GA9360@c2.user-mode-linux.org>
References: <20080117105606.ff89e9e9.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
	<20080117211437.GA7573@c2.user-mode-linux.org>
	<20080117214150.GA25872@linux-os.sc.intel.com>
	<20080117230802.GA9360@c2.user-mode-linux.org>
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [uml-devel] [-mm Patch] uml: fix a building error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>

 

>-----Original Message-----
>From: Jeff Dike [mailto:jdike@addtoit.com] 
>Sent: Thursday, January 17, 2008 3:08 PM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; Mariusz Kozlowski; WANG Cong; 
>linux-kernel@vger.kernel.org; 
>user-mode-linux-devel@lists.sourceforge.net; David Miller; 
>sparclinux@vger.kernel.org; Ingo Molnar; Thomas Gleixner
>Subject: Re: [-mm Patch] uml: fix a building error
>
>On Thu, Jan 17, 2008 at 01:41:50PM -0800, Venki Pallipadi wrote:
>> > And while we're on the subject, what's the deal with these, in
>> > include/asm-x86/io.h?
>> > 
>> > #define ioremap_wc ioremap_wc
>> > #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
>> > 
>> 
>> If archs want to override the defaults for these two 
>functions, they define
>> the above and then include asm-generic/iomap.h.
>
>That wasn't really the question.
>
>#define X X
>
>is a no-op, yes?
>

Later there is code in generic.h which is doing
#ifndef ioremap_wc
#define ioremap_wc ioremap_nocache
#endif
	

Thanks,
Venki

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
