Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Tuqrn-0007b3-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2013 20:42:47 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tuqre-0001zs-KV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2013 20:42:47 +0000
Message-ID: <50F46DAC.2070609@bob-the-boat.me.uk>
Date: Mon, 14 Jan 2013 20:42:20 +0000
From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
MIME-Version: 1.0
References: <50F132F9.1030601@bob-the-boat.me.uk> <1556600.9mAckIm5pW@vault01>
	<20130112170002.530c4a9a@spider.haslach.nod.at>
	<3776844.6K58P5x2hc@vault01>
	<20130112230654.4462c938@spider.haslach.nod.at>
In-Reply-To: <20130112230654.4462c938@spider.haslach.nod.at>
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
Subject: Re: [uml-devel] "Couldn't grant pty"
To: Richard Weinberger <richard@sigma-star.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 12/01/2013 22:06, Richard Weinberger wrote:
> Am Sat, 12 Jan 2013 18:05:28 +0100 (CET)
> schrieb "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>:
>> Richard,
>>
>> In the 64 bit environment (with additional 32 bit glibc) that works,
>> I do: (/uml_test is a mount point for a filesystem)
>>
>> mount --bind /dev /<path_to_32_bit_stuff>/dev
>> mount --bind /proc /<path_to_32_bit_stuff>/proc
>> mount --bind /sys /<path_to_32_bit_stuff>/sys
>> mount --bind /uml_test <path_to_32_bit_stuff>/uml_test
> What about /dev/pts?
> Why the chroot anyways?
>
> Thanks,
> //richard
>
>

Richard,

Well, of course, I was thinking that setting up the bind mount of /dev
took everything else with it. I probably did know better, but it's my
mistake.
Explicitly adding:

mount --bind /dev/pts /<path_to_32_bit_stuff>/dev/pts

Makes everything work. Very sorry guys...

Why chroot?

I have had problems in the past with mixed environments. 

I maintain glibc and uclibc systems in various architectures, and find that keeping everything very separate keeps the confusion levels down.

David



------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

