Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwMVX-0002Ps-VC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 07:33:31 -0800
Received: from lon-del-02.spheriq.net ([195.46.50.98])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CwMVW-0004zh-3X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 07:33:31 -0800
Received: from lon-inc-02.spheriq.net ([195.46.50.66])
	by lon-del-02.spheriq.net with ESMTP id j12FWeIT001727
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Feb 2005 15:33:18 GMT
Received: from lon-out-01.spheriq.net (lon-out-01.spheriq.net [195.46.50.129])
	by lon-inc-02.spheriq.net with ESMTP id j12FUhKs007919
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Feb 2005 15:30:43 GMT
Received: from lon-cus-01.spheriq.net (lon-cus-01.spheriq.net [195.46.50.37])
	by lon-out-01.spheriq.net with ESMTP id j12FUhg9012436
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Feb 2005 15:30:43 GMT
From: Alex LIU <alex.liu@st.com>
Message-ID: <021201c5093c$0ec75780$ac655e0a@sha.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
In-Reply-To: <200501282010.50020.blaisorblade@yahoo.it>
Subject: [uml-devel] RE: Explaination of system call function flow in TT mode
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
Date: Wed, 2 Feb 2005 23:29:59 +0800
Content-Transfer-Encoding: 8bit
To: 'Blaisorblade' <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,Blaisorblade. You wrote:

>do_syscall is called, and then this is done:
>
>                                sig = SIGUSR2;
>                                tracing = 0;
>... after, this saves the new tracing value inside "task", which is a struct 
>task_struct.
>
>                       set_tracing(task, tracing);
>

But what's the exact meaning of the task in the tracer function? It is defined as:

	task = cpu_tasks[proc_id].task

Is it the task struct of the traced thread?
What's the difference between "task->pid" and "task->thread.mode.tt.extern_pid"?
I know in TT mode every thread in UML will has a corresponding thread in host. But I don't know the exact relationship between them. And I didn't found how UML creat the corresponding thread in host.

Thanks a lot!

Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
