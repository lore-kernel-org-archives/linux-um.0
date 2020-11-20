Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgDyH-0008EB-Cy
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 21:29:34 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kgDyB-00Bc93-6P
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 22:29:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/4] um: suspend/resume
Date: Fri, 20 Nov 2020 22:29:17 +0100
Message-Id: <20201120212921.880781-1-johannes@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Hi,

So I've been playing with suspend/resume in my time-travel
environment, and things are actually quite decent with just
minimal effort (these patches).

Eventually, I think I'd like to implement proper hooks so
even kernel services are suspended properly, but that will
be a separate patch anyway.

Also, since virtqueues on virtio (vhost-user) devices are
just completely suspended, I don't have a way to wake up
from an external source, which would obviously be the most
interesting thing to do ... I suspect that to really do it
right we'd need another vhost-user spec extension to have a
new file descriptor, and then use a new UML interrupt that
can be marked as a wakeup source.

In any case, with this I can already do e.g.

	rtcwake -m mem -s 30

inside a system, in any kind of (non) time-travel mode, so
that's a start.

johannes




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

