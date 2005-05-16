Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXgc6-00075r-U8	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 07:30:34 -0700
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DXgc6-0001YD-HC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 07:30:34 -0700
Received: by rproxy.gmail.com with SMTP id j1so871581rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 May 2005 07:30:33 -0700 (PDT)
Message-ID: <3524bf1f05051607306756dcfc@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] The UML scheduler
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
Date: Mon, 16 May 2005 10:30:33 -0400
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I have studied the UML kernel a bit but it was hard to understand from
the code and some document in the web site. I have some questions
about the scheduling in UML. so, if anyone answer these, i really
appreciate it. Thank you!

As long as i know, each process running on top of UML kernel is viewed
as a process to the host kernel. then, the host kernel will try to
schedule the UML processes as normal processes. well, i'll have an
example.

suppose there are 2 processes on top of UML and 3 host processes.
then, the host kernel sees 5 processes total, so, each of the process
will get 20% of the CPU time? is that right?

Or, UML is somehow viewed as a group of processes and UML get 25% of
the CPU and each UML got 12.5% of the CPU time? if so, how is it
possible?

one more question, when the UML kernel wants to schedule its
processes, how does it preempt UML processes?

this way of scheduling and preemption will be different from TT mode
and SKAS mode? if so, how?

Thank you,


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_ids93&alloc_id=16281&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
