Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1cGXDR-00066T-Cn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 20:28:53 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cGXDP-0002x8-NY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 20:28:53 +0000
References: <1480789253.13532.5.camel@researchut.com>
	<CAFLxGvymHmbX=FpXFXWK4o6dzDrKA7TAMS84ABTuNGhNhFUEXg@mail.gmail.com>
	<1481569825.6973.1.camel@researchut.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <92a36a85-c90a-2c36-5a4b-1da9ee6f017a@nod.at>
Date: Mon, 12 Dec 2016 21:28:43 +0100
MIME-Version: 1.0
In-Reply-To: <1481569825.6973.1.camel@researchut.com>
Subject: Re: [uml-devel] Build failure on new gcc-6 on Debian Sid
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
To: rrs@researchut.com
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 12.12.2016 20:10, Ritesh Raj Sarraf wrote:
> On Mon, 2016-12-12 at 17:32 +0100, Richard Weinberger wrote:
>> Isn't this a toolchain bug?
>> Can you please try this fix?
>> https://sourceware.org/bugzilla/show_bug.cgi?id=20800
> 
> Thanks for the link. I think that'd fix the bug but I'll have to wait until 2.28
> hits into Debian.
> 
> There have been lots of build failures, in multiple tools, in Debian with this
> global change. And we've been overriding the default build flags for the failing
> tools. But for uml, adding the linker flag of -fno-pie did not help.

AFAICT this issue is unrelated to Debian's -fpie mess. :-)

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

