Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5zd-0006W6-FX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 04:20:57 -0800
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZ5zc-0003lY-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 04:20:57 -0800
Message-ID: <436F469B.3080607@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
	<200511022051.24335.blaisorblade@yahoo.it>
In-Reply-To: <200511022051.24335.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 07 Nov 2005 13:20:43 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>

Blaisorblade wrote:
> On Monday 31 October 2005 05:39, Jeff Dike wrote:
> 
>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>
>>Patch imlements full LDT handling in SKAS:
>> * UML holds it's own LDT table, used to deliver data on
>>   modify_ldt(READ)
>> * UML disables the default_ldt, inherited from the host (SKAS3)
>>   or resets LDT entries, set by host's clib and inherited in
>>   SKAS0
>> * A new global variable skas_needs_stub is inserted, that
>>   can be used to decide, whether stub-pages must be supported
>>   or not.
>> * Uses the syscall-stub to replace missing PTRACE_LDT (therefore,
>>   write_ldt_entry needs to be modified)
> 
> Two complaints against this patch (to be fixed afterwards, so I'm not CC'ing 
> akpm):
> 
> *) It reverts my cleanup and consolidation of ldt.c wrt. SKAS vs TT.
> 
> Or at least so I think (I must still give a proper look afterwards, and I'll 
> post patches). Actually it seems that this is done on purpose, but I don't 
> agree too much on this. I will see.

 From the beginning my new code for SKAS included the checks/buffering you later
inserted for TT and SKAS. So this patch is a second version adapted to your changes.
It shifts your improvements into TT path only (where I didn't do any changes in
my old patch), while it uses my own stuff for SKAS. Thus the patch doesn't really
revert your improvements, but restricts it to TT. As in SKAS0 UML now holds its own
LDT data, there is no need for buffering in this case. So I think it makes sense to
have separate code for SKAS.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
