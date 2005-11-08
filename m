Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZVM0-0002I7-Sv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 07:25:44 -0800
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZVLx-0003CM-UL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 07:25:44 -0800
Message-ID: <4370C36E.2040205@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
	<200511022051.24335.blaisorblade@yahoo.it>
	<436F469B.3080607@fujitsu-siemens.com>
	<200511072028.23111.blaisorblade@yahoo.it>
In-Reply-To: <200511072028.23111.blaisorblade@yahoo.it>
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
Date: Tue, 08 Nov 2005 16:25:34 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>

Blaisorblade wrote:
> On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>On Monday 31 October 2005 05:39, Jeff Dike wrote:
>>>
>>>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> 
> 
>>>Or at least so I think (I must still give a proper look afterwards, and
>>>I'll post patches). Actually it seems that this is done on purpose, but I
>>>don't agree too much on this. I will see.
> 
> 
>> From the beginning my new code for SKAS included the checks/buffering you
>>later inserted for TT and SKAS. So this patch is a second version adapted
>>to your changes. It shifts your improvements into TT path only (where I
>>didn't do any changes in my old patch), while it uses my own stuff for
>>SKAS. Thus the patch doesn't really revert your improvements, but restricts
>>it to TT. As in SKAS0 UML now holds its own LDT data, there is no need for
>>buffering in this case. So I think it makes sense to have separate code for
>>SKAS.
> 
> Yep, ok - I'm undecided about the new code for SKAS3, but it may make sense 
> (i.e. no opinion).
> 
> Instead, I have another question: is there a proper reason for using the 
> processor format for storing the info and translating it back to (struct 
> user_desc)? I am planning to avoid this double translation because I don't 
> like it. Any opinion?

In my opinion there is no reason to change the current implementation for SAKS3/0.
Note: if someone reads LDT via [sys_]modify_ldt(), he will receive the requested
data in "processor format", that is LDT-descriptors. He will receive a list of
descriptors starting at the first descriptor of the LDT, thus no entry number is
needed in the enties.
The only case that uses user_desc is when writing one desriptor via modify_ldt().
modify_ldt(WRITE) exactly writes one LDT-descriptor, so user_desc must contain
the number of the entry to write. Thus user_desc is bigger than LDT descriptor.
It also uses an other data layout resulting in double the size of LDT-descriptor.
So I think it doesn't make sense to store user_desc. We save memory storing the
resulting LDT-descriptors, which then are copied transparently on modify_ldt(READ).
Conversion between user_desc and LDT-entry is done on modify_ldt(WRITE) in SKAS0
only. No other conversions are done in UML.

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
