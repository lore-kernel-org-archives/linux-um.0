Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1Vgwy2-0001bY-BL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Nov 2013 13:28:18 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vgwy0-0002F5-C7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Nov 2013 13:28:18 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 3E7791D1C51
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 14 Nov 2013 14:25:48 +0100 (CET)
MIME-Version: 1.0
Date: Thu, 14 Nov 2013 14:25:48 +0100
From: stian@nixia.no
In-Reply-To: <52811BDA.2090705@google.com>
References: <52811BDA.2090705@google.com>
Message-ID: <4f471bf7dfaf984b17121486aeeb8233@nixia.no>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] uml: Simplify tempdir logic.
To: user-mode-linux-devel@lists.sourceforge.net

Den 2013-11-11 19:03, skrev Tristan Schmelcher:
> +	static const char fallback_dir[] = "/tmp";
> +	static const char * const tmpfs_dirs[] = {
> +		"/dev/shm",
> +		fallback_dir,
> +		NULL
> +	};

You should probably add /run/shm to the list of tmpfs directories to 
test for (ubuntu systems atleast use this).

Stian Skjelstad

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

