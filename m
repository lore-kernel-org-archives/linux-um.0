Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXB7I-0004Pw-1O
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 19:15:52 -0800
Received: from godel.catalyst.net.nz ([202.49.159.12] helo=mail2.catalyst.net.nz)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXB7H-0007f4-Ku
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 19:15:51 -0800
Message-ID: <3FE26D5F.3040109@catalyst.net.nz>
From: Srdjan <srdjan@catalyst.net.nz>
MIME-Version: 1.0
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz> <20031219002949.GX18100@alcor.net> <3FE25502.2010205@catalyst.net.nz> <20031219015812.GS18100@alcor.net>
In-Reply-To: <20031219015812.GS18100@alcor.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Dec 2003 16:15:43 +1300
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431-forwarded@bugs.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

To add:

- - although config con1 returns OK xterm I don't get an xterm opened
- - cad doesn't work, but halt does

Matt Zimmerman wrote:
| On Fri, Dec 19, 2003 at 02:31:46PM +1300, Srdjan wrote:
| 
| 
|>I seem to be able to connect to it:
|>
|>srdjan@nietzsche:/plato-home/srdjan$ uml_mconsole wWko45
|>(wWko45) config eth0
|>ERR No get_config routine defined
|>(wWko45) cad
|>OK 
|>
|>although cad didn't do anything.
| 
| 
| What does "config con1" say?
| 
| 
|>It worked yesterday with 2.4.22-5um-1, I only could not make network go,
|>which I hoped to resolve today (but then I upgraded...:) I've installed
|>kernel-patch-skas, but it refused to patch my 2.4.22 kernel. Any
|>suggestions?
| 
| 
| Make sure you have the latest version of kernel-patch-skas; that version
| works fine with 2.4.22.
| 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/4m1fX4ZD19jq88YRAsMfAJ92zjs+smpmC9Y1rbRv8rkC7Nvk5QCgucdK
WXSgRJH/QpC8w3LFnD9aAL8=
=MTm7
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
