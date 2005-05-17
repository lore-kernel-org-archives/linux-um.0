Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXpeq-0006ZA-Ny	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 17:10:00 -0700
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DXpeL-0000tU-4F	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 17:10:00 -0700
Received: by rproxy.gmail.com with SMTP id j1so1009142rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 May 2005 17:09:28 -0700 (PDT)
Message-ID: <3524bf1f0505161709476c4940@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
In-Reply-To: <200505162324.37749.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	 <200505161908.08373.blaisorblade@yahoo.it>
	 <3524bf1f05051611528eb7bc1@mail.gmail.com>
	 <200505162324.37749.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 20:09:28 -0400
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Ok, now i'm getting close. Thanks a lot!!!=20
but i have two more :)

1) in SKAS mode, the tracer (UML kernel) will execute a system call
for the tracee (the user process). But what if the system call blocks?
then, the tracer, the UML kernel, will be blocked, too, right? it
means the whole UML system will be blocked?

2) in TT mode, what if the user process (tracee) installs its own
signal handler for SIGUSR2?

Thank you,


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
