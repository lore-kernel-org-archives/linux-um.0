Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A01lF-0002eD-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 09:36:05 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A01lE-0001Y2-UK
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 09:36:05 -0700
Received: from [194.97.50.138] (helo=mx0.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.23)
	id 1A01lC-00074H-D4
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 18:36:02 +0200
Received: from b292a.pppool.de ([213.7.41.42] helo=home.petschge.de)
	by mx0.freenet.de with esmtp (Exim 4.23 #2)
	id 1A01lB-0004I2-BI
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 18:36:02 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id A445A3BCE5
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 14:14:36 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id 687663BCE4
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 14:14:35 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] Problem with 2.4.22-um4 
References: <BAY7-F103PPYPeOqp2N00015916@hotmail.com> <200309172220.h8HMKANu021258@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030918121435.687663BCE4@home.petschge.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Sep 2003 14:14:35 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

Jeff Dike wrote:
>> Jeff didn't like a part of my patch, but didn't back out all of the
>> related  bits.
> Crap.  I backed out the while -> do { ... } while part of that particular
> change, but forgot to keep the read -> os_read_file part.

Doesn't real matter how it happend, as long as the patch on the website is 
fixed.

mfg,
Patrick "Petschge" Kilian

-- 
Erst wenn das letzte Closed-Source-System gehackt ist, werdet ihr
merken, dass man Sicherheit nicht durch Verschleierung oder durch
Gesetze erreicht.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
