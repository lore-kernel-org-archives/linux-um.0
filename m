Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOR2A-0004Hx-NT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 17:58:42 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BOR2A-0007Ox-9S
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 17:58:42 -0700
Message-Id: <200405140143.i4E1hWZB005226@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.4.24-3 
In-Reply-To: Your message of "Thu, 13 May 2004 17:01:11 EDT."
	<40A3E217.2080104@nortelnetworks.com> 
References: <200405122208.i4CM8cCe008920@ccure.user-mode-linux.org>
	<40A3E217.2080104@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 13 May 2004 21:43:32 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

gmarzot@nortelnetworks.com said:
> I wonder based on what you say here if two UMLs that hostfs mount the
> same directory and access the same file...one for reading, and the
> other  for writing, if the first will see the updates written by the
> second....or maybe I am misinterpretting.

You are correct, the writer will cache the new data, and the reader won't see
it until it's flushed out somehow.  If you can arrange to have the writer sync 
the filesystem before the reader reads the files, then it will get up-to-date 
information.

Otherwise, if this is a problem, we need to make hostfs optionally synchronous.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
