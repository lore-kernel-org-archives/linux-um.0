Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<011001c44c0d$ebdeceb0$dd02a8c0@ferraro>
	<008901c44c40$c2ed0e30$dd02a8c0@ferraro>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <008901c44c40$c2ed0e30$dd02a8c0@ferraro> (uml@dot1q.net's
	message of "Sun, 06 Jun 2004 23:37:30 -0400")
Message-ID: <878yerf7d4.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 13 Jun 2004 22:58:15 +0100
To: uml <uml@dot1q.net>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

On Sun, 06 Jun 2004, uml@dot1q.net stipulated:
> Switch differences between -O1 and -O2 on GCC 3.3.3:

Note: -O{n} are *not* the equivalent of groups of -f switches:
they turn those switches on, but other things inside the compiler
are directly triggered by the optimization level.

-- 
`If you believe in strong AI, then death is no longer a mystery,
 but merely a lack of adequate backups.' --- Steven McDougall


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
