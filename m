Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ck2x0-0006PH-40 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Dec 2004 08:14:58 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Ck2wq-0005CL-39 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Dec 2004 08:14:57 -0800
In-Reply-To: <200412301520.48951.Armin.Warda@gmx.de>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<20041216183604.GB24982@bytesex>
	<200412162013.21197.blaisorblade_personal@yahoo.it>
	<200412301520.48951.Armin.Warda@gmx.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E54DD071-5A7D-11D9-853A-0003931D03FE@theshore.net>
Content-Transfer-Encoding: 7bit
From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
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
Date: Thu, 30 Dec 2004 11:14:34 -0500
To: Armin.Warda@gmx.de
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

You need to run 2.6.10, as it doesn't exhibit the tmpfs filling up 
problem like 2.6.9 variants do.  The tmpfs problem is also compounded 
by the fact that UMLs without the fix-kill patch don't exit properly, 
but the 2.6.9-bb4 patchset has the fix for UML.

For 2.4-um, you can find the fix-kill patch here:
http://www.theshore.net/~caker/uml/patches/2.4.27-1um/

-Chris

On Dec 30, 2004, at 9:20 AM, Armin M. Warda wrote:

>   Hi,
>
> just tried again with SuSE host kernel 2.6.8-24.10: same problem.
>
> (Is 2.6.8-24.10 a 2.6.8 with back-ported fixes from 2.6.10 ?)
>
>   Armin.
>
> On Thursday 16 December 2004 20:13, Paolo Giarrusso wrote:
>> On Thursday 16 December 2004 19:36, Gerd Knorr wrote:
>>>> Well, this matches some other reports of a different problem
>>>> (impossible to unmount a fs used by UML) which probably relates
>>>> to 2.6.9 host bugs.
>>>>
>>>> I'd suggest trying to reproduce the bug with a 2.6.8.1 +
>>>> SKAS3-v7 patch, or checking what's different in the SuSE kernel
>>>> from vanilla 2.6.8.1 (I'm particularly suspiscious about the
>>>> TASK_TRACED introduction).
>>>
>>> The suse 2.6.8 kernel is actually 2.6.9-rc2, thus more close to
>>> 2.6.9 than 2.6.8.  Especially it already has the TASK_TRACED
>>> stuff and I've used the 2.6.9 version of the skas v7 patch
>>>
>>> (and also thats why I've
>>> suggested to check against 2.6.9 not 2.6.8.1 vanilla to see if
>>> the issue is still there).
>>
>> Remember that there was an invisible reference from died UMLs that
>> kept the tmpfs from being unmounted (multiply reported, I
>> experienced that too). Well, it the file is kept used, then it will
>> keep using the tmpfs space. So nothing new....
>
> -- 
>    --- May the Source be with you! Linux. ---
>    --- secure eMail: http://www.gnupg.de/ ---



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
