Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdVbI-0004wa-NQ
 for linux-um@lists.infradead.org; Fri, 13 Nov 2020 09:42:39 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: We may want to redefine asprint and vasprintf in the user headers
Message-ID: <85e05ffa-d539-b2a9-6e4f-2cc11f49beec@cambridgegreys.com>
Date: Fri, 13 Nov 2020 09:42:32 +0000
MIME-Version: 1.0
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>, ",richard"@nod.at

Summary - we cannot use asprintf on the user side.

The use of asprintf in umid.c resulted in slab memory corruption.

In most cases it is harmless - just dumping a backtrace on startup the moment you try to free the string allocated by asprintf. It can, for some values of umid, end up in a startup crash.

I will amend my patch which was removing the extraneous snprintf in umid shortly to do the opposite - remove the asprintf and use the older snprintf approach.

It may be a good idea to add an include to the user side which redefines asprintf as a compile time error.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

