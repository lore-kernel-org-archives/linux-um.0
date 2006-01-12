Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ExBDX-0007Cz-Qr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2006 14:46:51 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ExBDV-00032N-Fh
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2006 14:46:51 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] high-performance system calls using vsyscall
Message-ID: <20060112233848.GA945@ccure.user-mode-linux.org>
References: <3524bf1f0601120902v3812029l4d8ba5411b53f36f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f0601120902v3812029l4d8ba5411b53f36f@mail.gmail.com>
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
Date: Thu, 12 Jan 2006 18:38:48 -0500
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 12, 2006 at 12:02:16PM -0500, Young Koh wrote:
> I found an old post discussing the possibility of turning a system
> call into a procedure call using vsyscall. Is it really implemented in
> recent versions? I tested with recent Linux/UML kernels and glibcs but
> system calls don't seem that fast. so, i guess it's not implemented
> yet?

In the generic kernel (or in whatever arches have the vsyscall page),
it's used for only a small number of system calls.

In a tt-style UML, where the UML kernel is in the same address space
as the process, this could be used for all system calls, where you
would just jump from there into the UML kernel.  I think you would
have to fiddle libc to make all of the system calls fo this.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
