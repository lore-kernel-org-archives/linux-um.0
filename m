Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aewi1-0000TS-7d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:29:53 -0800
Received: from [65.117.135.105] (helo=kartuli.timesys)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aewi0-0004vf-NQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:29:52 -0800
Message-ID: <3FFEACBC.7060704@timesys.com>
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com> <3FFEAA6C.8020002@timesys.com>
In-Reply-To: <3FFEAA6C.8020002@timesys.com>
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
Date: Fri, 09 Jan 2004 08:29:32 -0500
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>, user-mode-linux-devel@lists.sourceforge.net

La Monte H.P. Yarroll wrote:

> Nuno Silva wrote:
>
>> Hi!
>>
>> I've been trying for days and made lots of tests and it seems that the
>> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled 
>> glibc.
>>
>> I've made some tests that you can check here:
>> http://sourceforge.net/mailarchive/message.php?msg_id=6897520
>>
>> This setup without tls+nptl (glibc compiled with
>> --enable-addons=linuxthreads) works fine with UML.
>>
>> Sooner or later everybody will have 2.6 and the new glibc :-)
>>
>> Any tips? 
>
>
> The calls set_thread_area(2) and get_thread_area(2) are not 
> implemented in UML.
> Both are essential to NPTL.  There may be other problems too...
>
> Implementing them gets really tricky if you want UML to work with a 
> 2.4.x host.
> I've been trying to steal enough cycles to learn enough to just 
> implement them on a 2.6.0 host.

I should know better than to post on only one cup of coffee.

I remember why I didn't reply before--you are struggling with the dual 
to my problem.  This
is bad news for me because it means that even if the host implements TLS 
it can not
use NPTL.

Going back through your posting it looks like it probably does not 
matter if the host kernel
implements TLS as long as libc does not use NTPL.  Is this a correct 
interpretation?




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
