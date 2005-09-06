Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECgVA-0004Jj-SC	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:40:52 -0700
Received: from rgminet04.oracle.com ([148.87.122.33])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1ECgV9-0004cd-Lz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:40:53 -0700
Message-ID: <431DB9ED.4030300@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] stack and scheduler patches
References: <431637F9.6030101@oracle.com>
	<20050902165935.GA6651@ccure.user-mode-linux.org>
In-Reply-To: <20050902165935.GA6651@ccure.user-mode-linux.org>
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
Date: Tue, 06 Sep 2005 11:46:53 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Void casting: my compiler gave me a warning, and I don't like that.
pid=-1, leftover from error checking that i didn't need, my fault.
pid=0, find_task_by_pid(0) will return a valid pointer, but it doesn't 
seem to really be a good task.  This seems to be related to the kernel 
idle task.  If you pass 0, it will seg fault w\o the check.
I'm not sure what a signed off-by does, but long as i can get bb to 
agree with this....  i'm okay with it. :)
Allan


Jeff Dike wrote:

>On Wed, Aug 31, 2005 at 07:06:33PM -0400, Allan Graves wrote:
>  
>
>>Jeff,
>>Here's the patches.  Hope these meet your approval!
>>Allan
>>    
>>
>
>Some comments - I have these all fixed:
>
>	+        struct task_struct *from=(struct task_struct*)prev;
>	+        struct task_struct *to=(struct task_struct*)next;
>There's no need to cast when the source is a void *
>
>	+          CHOOSE_MODE(switch_to_tt(prev, next),
>	+             switch_to_skas(prev, next));
>There's a CHOOSE_MODE_PROC which lets you avoid repeating common argument
>lists, although I was doing this wrong here too.
>
>	+extern int switch_to_skas(void *prev, void *next);
>	+extern int switch_to_tt(void *prev, void *next);
>Since these can't do anything but return 0, they might as well be void
>
>	+        if (0==sscanf(ptr, "%d", &pid_requested) || pid_requested==-1) {
>The pid_requested==-1 is redundant - if sscanf failed, we just want to bail out
>
>	+        if((!to) || (pid_requested == 0)) {
>Why the check against 0?
>
>	+		next=(void *)current->thread.saved_task;
>	+		prev=(void*)current;
>No need to cast when the target is a void * either
>
>Also, OK for me to add a Signed-off-by: you?
>
>				Jeff
>  
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
