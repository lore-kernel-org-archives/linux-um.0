Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCVsw-00079t-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 20:43:54 -0700
Received: from dsl093-055-110.blt1.dsl.speakeasy.net
	([66.93.55.110] helo=mail.d20boards.net ident=1014)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BCVsw-0001cl-CA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 20:43:54 -0700
Message-ID: <4094.66.93.55.203.1081655159.squirrel@mail.d20boards.net>
In-Reply-To: <407865A4.4070403@upb.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net> 
	<185d01c41e23$5996cc00$2000000a@schlepptopp> 
	<189201c41e30$d434cc70$2000000a@schlepptopp> 
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org> 
	<c58kbu$el1$1@sea.gmane.org> 
	<20040410140840.GB5782@ccure.user-mode-linux.org> 
	<4077FDF9.7070707@upb.de> 
	<20040410170707.GA6492@ccure.user-mode-linux.org> 
	<407865A4.4070403@upb.de>
Subject: Re: [uml-devel] Re: [uml-user] Network lags
From: "attriel" <attriel@d20boards.net>
Reply-To: attriel@d20boards.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 10 Apr 2004 23:45:59 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

>>>what's so bad about it?
>>
>> It can put the host at risk.  There's a VM system for a reason, and it
>> needs
>> swap in order to be able to back out of memory shortages.  mlocking
>> large
>> amounts of memory subverts that and increases the possibility of
>> deadlocking.
>
> good point, but mlocking 128M should be like running the host with 128M
> less. so if i could tell the kernel not to touch a certain memory-area

Well, my problem is that I'm consistently running multiple UMLs on one
machine, so I like the ability for it to swap stuff in or out when it
needs it

The adaptive memory thing Jeff was talking about sound really cool, to me,
as well.  But fully dedicating things would be bad for me :o


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
