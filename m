Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUn6x-0008In-Dw
 for linux-um@lists.infradead.org; Tue, 20 Oct 2020 08:35:16 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: The UMID fixes need to be added to stable
Message-ID: <aa967d60-ba8c-5915-1ee1-b7792e20a77b@kot-begemot.co.uk>
Date: Tue, 20 Oct 2020 09:35:09 +0100
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
Cc: richard@nod.at

Hi list, hi Richard,

I figured out the other bug where I was getting weird crashes on older versions - my machine was using larger pid numbers.

IMHO we need to push the two UMID fixes - ba758cfce00a5977ccf019926f8379a96f5ac5f6 and e8a58591afbc7dc279a11454c08fce1281958eef to stable.

Brgds,
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

