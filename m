Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGje2-0005V9-Lb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 12:18:30 -0800
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DGjdz-0002Qr-TL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 12:18:30 -0800
Received: from [194.97.55.190] (helo=mx6.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.51) id 1DGjdv-00033y-Va
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 22:18:23 +0200
Received: from i954f.i.pppool.de ([85.73.149.79] helo=bakunin.copyleft.de)
	by mx6.freenet.de with esmtpsa (ID freenet_bakunin@freenet.de)
	(TLSv1:AES256-SHA:256) (Exim 4.43 #13) id 1DGjdv-00077M-OO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 22:18:23 +0200
Received: from kraehe by bakunin.copyleft.de with local (Exim 4.50)
	id 1DGjdu-0001J1-SK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 22:18:22 +0200
From: kraehe <kraehe@copyleft.de>
Message-ID: <20050330201822.GA4962@copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] NFS/UDP/uml_switch/tap0 problems with
	2.6.11.6-skas3-v9-pre1
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
Date: Wed, 30 Mar 2005 22:18:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Moin Guru's,

  i've some new hardware - suggesting 2.6 kernel. So I'm now running
  2.6.11.6-skas3-v9-pre1 as host on this system. The old client kernel
  2.4.22-uml1-5um looked to work fine, together with the old uml_switch
  and uml_mconsole I had.
  
  Problems started when I've tried to NFS mount the host from client.
  At first it works, but NFS hangs, if its used under load. I've tested
  the following cases with the uml-utilities provided by Debian/Sarge :

  - server 2.6.11.6-skas3-v9-pre1
  - client 2.4.22-uml (the uml system)
      - nfs/tcp using uml_switch/tap0 is fine
      - nfs/udp using uml_switch/tap0 is hangs under load
  - client 2.6.7-skas3 (my laptop using ethernet to compare the normal case)
      - nfs/udp using eth0 is fine
      - nfs/tcp using eth0 is fine

  after reboot of both host and user mode linux :

  - same server but 2.4.29-skas3 kernel
  - same client 2.4.22-uml
      - nfs/tcp using uml_switch/tap0 is fine
      - nfs/udp using uml_switch/tap0 is fine

  So I circled the problem to 2.6.11.6 hosting kernel and nfs/udp -
  any further ideas how/where to debug this problem ?

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
