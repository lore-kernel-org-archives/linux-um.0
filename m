Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ6R1-00061T-7c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 07:55:31 -0800
Received: from web26105.mail.ukl.yahoo.com ([217.12.10.229])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CQ6Qx-00057c-H4 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 07:55:30 -0800
Message-ID: <20041105155432.49097.qmail@web26105.mail.ukl.yahoo.com>
From: Roland Kaeser <roli8200@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] con=port hangs uml guest when it trys to create mingettys
	for the ttyp's
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
Date: Fri, 5 Nov 2004 16:54:32 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

Hello

I try to use con=port:<number> for the local uml guest consoles. But I recognized
that the uml guest system hangs unless a telnet connection to the port was made,
while creating the mingettys for the ttyps on startuptime. 
On Fedora look on /etc/rc.d/rc.sysinit for the section:

if [ "$HOSTTYPE" != "s390" -a "$HOSTTYPE" != "s390x" ]; then
  last=0
  for i in `LC_ALL=C grep '^[0-9].*respawn:/sbin/mingetty' /etc/inittab | sed 's/^.*
tty\([0-9][0-9]*\).*/\1/g'`; do
        > /dev/tty$i
        last=$i
  done
  if [ $last -gt 0 ]; then
       > /dev/tty$((last+1))
       > /dev/tty$((last+2))
  fi
fi

With uml kernel 2.6.9 and host kernel 2.6.7(SKAS)

Some ideas?

Roland


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
