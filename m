Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GxPyH-0004m7-Jp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Dec 2006 07:36:38 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GxPyF-00085Y-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Dec 2006 07:36:37 -0800
Message-ID: <458AAA0D.4020507@theshore.net>
Date: Thu, 21 Dec 2006 10:36:45 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <4525802F.1080900@theshore.net>
	<200610210305.37629.blaisorblade@yahoo.it>
In-Reply-To: <200610210305.37629.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.18-skas-v9-pre9 broken
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Thursday 05 October 2006 23:59, Christopher S. Aker wrote:
>> Blaisorblade,
>>
>> I recently deployed a 2.6.18-skas3-v9-pre9 host, and some users weren't
>> able to boot UML beyond "VFS: Mounted root (ext3 filesystem) readonly".
>>   As it turns out, only 2.6-um kernels were affected, 2.4-um worked fine.
>>
>> This happened both in skas3 and skas0 modes.  Jeff graciously took a
>> look at some straces, and his comment was that "something broke page
>> fault handling generically".
>>
>> The traces are here:
>>
>> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace.txt (skas3)
>> http://www.theshore.net/~caker/uml/skas2.6.18-uml_trace_skas0.txt
>>
>> Reverting back to a skas3-v8.2 kernel fixed it.
> 
> An important question: you reverted to a 2.6.18 + skas kernel or a 2.6.17 one? 
> A similar bug is being discussed about a regression in 2.6.18 vanilla...

Uh, somehow I missed this email for two months...

All my hosts are running at most 2.6.16.x, so this very well could be a 
regression in post 2.6.16 kernels.

-Chris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
