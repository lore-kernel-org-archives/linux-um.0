Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTWWB-0008Hh-Cs	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 19:55:15 -0700
Received: from h190.c26.b96.tor.eicat.ca ([66.96.26.190]
	helo=moraine.clusterfs.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DTWW9-000283-Rb	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 19:55:15 -0700
Received: from [137.186.136.18] (d137-186-136-18.abhsia.telus.net
	[137.186.136.18])	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by moraine.clusterfs.com (Postfix) with ESMTP id 7FEAD31026D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  4 May 2005 22:55:03 -0400 (EDT)
Message-ID: <42798ADD.5070607@yahoo.com.cn>
From: "Mei,Jia" <cfs_eric@yahoo.com.cn>
MIME-Version: 1.0
Subject: Re: [uml-devel] gdb debugging problem on uml-2.6.10
References: <4271073D.3030800@yahoo.com.cn>
	<200505011216.27331.blaisorblade@yahoo.it>
In-Reply-To: <200505011216.27331.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 04 May 2005 20:54:21 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
>>When I try gdb-5.3.90 with uml in vanilla-2.6.10 kernel. I found a problem.
>>
>>When I set a breakpoint somewhere, and after some step, uml will
>>always get a SIGTRAP signal and trap into gdb.
>>
>>Does anyone met the same problem as me? Any known fix for it?
> 
> No, I don't think there is any known fix for it. However, does this problem 
> keep on and makes debugging impossible (i.e., after you "cont", does it keep 
> stopping)?
> 
> Hmm, are you doing debugging in SKAS or in TT mode? In the second case, then 
> it can be a bug in the ptrace proxy (which has a big bug with some gdb 
> releases >= 6.0).
> 
> In the first case, maybe it's something I observed too (I'm not sure because I 
> don't use a lot gdb with UML)... Better, I've observed breakpoints being 
> *skipped* by gdb.

I'm sorry for the late response since away for a few days. It turn out 
to be the rootfs problem, although I don't know why (not related to 
tls), change to a new rootfs fixed it. Maybe don't need to chase more on 
this.
And appreciate you and Jeff's reply.

Eric


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
