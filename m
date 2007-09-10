Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUsL5-0004NB-0G for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 16:06:43 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IUsL4-0000z5-MV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 16:06:42 -0700
Message-ID: <46E5CE03.6000009@theshore.net>
Date: Mon, 10 Sep 2007 19:06:43 -0400
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <46E016D8.4000803@theshore.net>
	<20070910161400.GF14112@c2.user-mode-linux.org>
In-Reply-To: <20070910161400.GF14112@c2.user-mode-linux.org>
Subject: Re: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Thu, Sep 06, 2007 at 11:03:52AM -0400, Christopher S. Aker wrote:
>> 2.6.22.6-um
>>
>> init_new_context_skas - new_mm failed, errno = -24
>> init_new_context_skas - new_mm failed, errno = -24
>> init_new_context_skas - new_mm failed, errno = -24
>> Kernel panic - not syncing: switch_mm_skas - PTRACE_SWITCH_MM failed, 
>> errno = 9
> 
>> Is this cause by a still-too-low max_map_count value?
> 
> Could be - what was the host's max_map_count?
> 
> 				Jeff

root@atlanta20:~# cat /proc/sys/vm/max_map_count
500000
root@atlanta20:~# free -g
              total       used       free     shared    buffers     cached
Mem:            23          8         15          0          0          7
-/+ buffers/cache:          0         23
Swap:            1          0          1

-Chris



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
