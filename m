Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxCfk-0007ef-Ey for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 15:15:32 -0800
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CxCfj-000616-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 15:15:32 -0800
Message-ID: <4204020F.2000501@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
References: <42021E35.8050601@fujitsu-siemens.com>	<4202C18F.5010605@yahoo.com.au>	<42036C2C.5040503@fujitsu-siemens.com>	<4203F40C.8040707@yahoo.com.au>
	<20050204143917.1f9507cb.akpm@osdl.org>
In-Reply-To: <20050204143917.1f9507cb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Race condition in ptrace
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
Date: Sat, 05 Feb 2005 10:15:27 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Bodo Stroesser wrote:
>>
>>>Nick Piggin wrote:
>>>
>>>
>>>>Bodo Stroesser wrote:
>>
>>>>I don't see how this could help because AFAIKS, child->saving is only
>>>>set and cleared while the runqueue is locked. And the same runqueue lock
>>>>is taken by wait_task_inactive.
>>>>
>>>
>>>Sorry, that not right. There are some routines called by sched(), that 
>>>release
>>>and reacquire the runqueue lock.
>>>
>>
>>Oh yeah, it is the wake_sleeping_dependent / dependent_sleeper crap.
>>Sorry, you are right. And that's definitely a bug in sched.c, because
>>it breaks wait_task_inactive, as you've rightly observed.
>>
>>Andrew, IMO this is another bug to hold 2.6.11 for.
> 
> 
> Sure.  I wouldn't consider Bodo's patch to be the one to use though..

No. Something similar could be done that works on all architectures
and all wait_task_inactive callers (and is confined to sched.c). That
would still be more or less a hack to work around smtnice's unfortunate
locking though.




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
