Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwmPl-0006u8-Tz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 14:26:57 -0800
Received: from hu-out-0506.google.com ([72.14.214.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwmPi-0003Iw-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 14:26:53 -0800
Received: by hu-out-0506.google.com with SMTP id 28so714232hub
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Nov 2007 14:26:48 -0800 (PST)
Message-ID: <474B4823.8030609@gmail.com>
Date: Mon, 26 Nov 2007 23:26:43 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
References: <474A9701.4040908@gmail.com>
	<ea9232d10711261247y6c4a929of3fe88338e2ce659@mail.gmail.com>
In-Reply-To: <ea9232d10711261247y6c4a929of3fe88338e2ce659@mail.gmail.com>
Subject: Re: [uml-devel] PROC_MM
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
To: Karol Swietlicki <magotari@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>


Karol Swietlicki wrote:
> On 26/11/2007, Jiri Olsa <olsajiri@gmail.com> wrote:
>> Hi,
>>
>> I see some code related to PROC_MM
> 
> <snip>
> 
>> I did not find PROC_MM config option in the kernel or any other way to get /proc/mm file.
>> Is it just old code pending for removal, or am I missing smth... :)
> 
> There exists a patchset which allows you to run UML in skas3 mode. The
> said mode uses /proc/mm.
> I suppose the bit you are seeing is a small part of that patchset
> which did get to the mainline.

I see, anyway the latest SKAS3 patch I found is from 07-Feb-2007.
http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/

Where can I get the latest one? When is it going to the mainline?

> 
> Karol Swietlicki
> 

thanks,
jirka

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
