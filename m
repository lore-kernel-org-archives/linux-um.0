Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhsPf-0008Tx-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 07:31:03 -0800
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230] helo=mail.lig.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhsPf-0000nf-C2 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 07:31:03 -0800
Message-ID: <40095537.1090602@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
References: <4008A7DF.6000308@lig.net> <87llo6hmmc.fsf@bytesex.org>
In-Reply-To: <87llo6hmmc.fsf@bytesex.org>
Content-Type: multipart/mixed; boundary="------------000903050107070905010103"
Subject: [uml-devel] Re: What is the most up to date,
	least crashing kernel+patch?
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
Date: Sat, 17 Jan 2004 10:31:03 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------000903050107070905010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thank you very much!!

BTW, I solved stability and performance problems by lowering the memory 
setting ro 430M, using the 2.4.20 UML kernel, still with my 2.6.1+skas3 
host, and getting around to TMPDIR=/dev/shm (doh!).

If I can build in everything I need by rebuilding a kernel, I can live 
without modules.  In particular, I need IPv6, IPSec, and other advanced 
networking.

sdw

Gerd Knorr wrote:

>"Stephen D. Williams" <sdw@lig.net> writes:
>
>  
>
>>I would like 2.6.1 as a UML kernel along with support for >512 UML ram
>>and preferrably modules.  What is the best I can get right now?
>>
>>I'm running Gerd/SuSE's 2.6.0-test9,
>>    
>>
>
>ftp://ftp.suse.com/pub/people/kraxel/i386/ has 2.6.1 rpms since a few
>hours.  Both binary and source rpms, both uml and host, host with
>skas3, all building out a single source tree.  Modules don't work yet
>through.
>
>  Gerd
>
>  
>


-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw


--------------000903050107070905010103
Content-Type: text/x-vcard; charset=utf8;
 name="sdw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdw.vcf"

begin:vcard
fn:Stephen Williams
n:Williams;Stephen
email;internet:sdw@lig.net
tel;work:703-724-0118
tel;fax:703-995-0407
tel;pager:sdwpage@lig.net
tel;home:703-729-5405
tel;cell:703-371-9362
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000903050107070905010103--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
