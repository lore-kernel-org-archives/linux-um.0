Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVu1K-0000R8-RG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2004 07:52:58 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CVu1J-00053q-SI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2004 07:52:58 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CVu1H-0002Q6-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Nov 2004 16:52:55 +0100
Received: from 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	([209.6.22.202]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Nov 2004 16:52:55 +0100
Received: from lars by 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Nov 2004 16:52:55 +0100
From: Lars Kellogg-Stedman <lars@oddbit.com>
Message-ID: <lars-EEE351.10525221112004@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] URL parsing bug in Slim/Utils/Misc.pm
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
Date: Sun, 21 Nov 2004 10:52:52 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I proxy access to my slimserver management interface via an SSL proxy, 
and at some revision of the slimserver software I was no longer able to 
access the server settings (I received a 403 error).

I've tracked this down to the crackURL function in Slim/Utils/Misc.pm.  
It matches URLs using the string:

  $string =~ m|http://(?:([^\@:]+):?([^\@]*)\@)?([^:/]+):*(\d*)(\S*)|i;

When crackURL sees an https:// URL, it returns an empty $host and 
default $port to the caller -- which, for example, makes the referrer 
check in processHTTP fail.  Making a two character change to $string 
makes it work just fine with https:// URLs:

  $string =~ m|https?://(?:([^\@:]+):?([^\@]*)\@)?([^:/]+):*(\d*)(\S*)|i;

-- Lars



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
