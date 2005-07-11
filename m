Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds6js-0001JW-G2	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:27:00 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Ds6jr-0007f8-Rn	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:27:00 -0700
Message-ID: <42D2F22C.3060102@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
References: <20050709110143.D59181E9EA4@zion.home.lan>
	<20050709120703.C2175@flint.arm.linux.org.uk> <42D2C487.60302@rimuhosting.com>
	<200507120020.52418.blaisorblade@yahoo.it>
In-Reply-To: <200507120020.52418.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: unregister_netdevice: waiting for tap24 to become
	free
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
Date: Tue, 12 Jul 2005 10:26:52 +1200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Nothing in the logs prior to the first error message.

I've hit this before at different times on other servers.  If there are 
some commands I can run to gather more diagnostics on the problem, 
please let me know and I'll capture more information next time.

I see the error was reported with older 2.6 kernels and a patch was 
floating around.  I'm not sure if that is integrated into the current 
2.6.11 kernel. 
http://www.google.com/search?q=unregister_netdevice%3A+waiting

Regards, Peter

Jul 10 16:52:03 host39 sshd(pam_unix)[19779]: authentication failure; 
logname= uid=0 euid=0 tty=ssh ruser= rhost=140.123.23.77  user=halt
Jul 10 16:52:07 host39 sshd(pam_unix)[19781]: check pass; user unknown
Jul 10 16:52:07 host39 sshd(pam_unix)[19781]: authentication failure; 
logname= uid=0 euid=0 tty=ssh ruser= rhost=140.123.23.77
Jul 11 12:04:04 host39 kernel: unregister_netdevice: waiting for tap24 
to become free. Usage count = 1


Blaisorblade wrote:
> On Monday 11 July 2005 21:12, Peter wrote:
> 
>>Hi.  I am hitting a bug that manifests in an unregister_netdevice error
>>message.  After the problem is triggered processes like ifconfig, tunctl
>>and route refuse to exit, even with killed.
> 
> Even from the "D" state below, it's clear that there was a deadlock on some 
> semaphore, related to tap24... Could you search your kernel logs for traces 
> of an Oops?
> 
>>And the only solution I 
>>have found to regaining control of the server is issuing a reboot.
> 
> 
>>The server is running a number of tap devices.  (It is a UML host server
>>running the skas patches http://www.user-mode-linux.org/~blaisorblade/).
>>
>>Regards, Peter
>>
>># uname -r
>>2.6.11.7-skas3-v8
>>
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>
>>
>>30684 ?        DW     0:45          \_ [tunctl]
>>31974 ?        S      0:00 /bin/bash ./monitorbw.sh
>>31976 ?        S      0:00  \_ /bin/bash ./monitorbw.sh
>>31978 ?        D      0:00      \_ /sbin/ifconfig
>>31979 ?        S      0:00      \_ grep \(tap\)\|\(RX bytes\)
>>32052 ?        S      0:00 /bin/bash /opt/uml/umlcontrol.sh start --user
>>gildersleeve.de
>>32112 ?        S      0:00  \_ /bin/bash /opt/uml/umlrun.sh --user
>>gildersleeve.de
>>32152 ?        S      0:00      \_ /bin/bash ./umlnetworksetup.sh
>>--check --user gildersleeve.de
>>32176 ?        D      0:00          \_ tunctl -u gildersleeve.de -t tap24
>>


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
