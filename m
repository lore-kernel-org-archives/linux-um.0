Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldtAY-003vrx-IG
 for linux-um@lists.infradead.org; Tue, 04 May 2021 11:24:52 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Potential races in SIGIO vs Epoll order
Message-ID: <b1cbe860-4761-f997-74e2-d82e1e084e5b@cambridgegreys.com>
Date: Tue, 4 May 2021 11:42:04 +0100
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
To: linux-um@lists.infradead.org
Cc: zhuyifei1999@gmail.com

Hi all,

I got around to look at the race discovered by YiFei Zhu in http://lists.infradead.org/pipermail/linux-um/2021-April/001396.html

While UML works using an epoll helper to generate SIGIO, it is ~ 5 times slower compared to enabling async IO. So this is not usable as the primary mode of operation for the interrupt controller.

I am going to play with it a bit further and try get it to do a "epoll not serviced" check only occasionally - to handle errors and IRQ controller stalls.

Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

