Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmzwv-0000Cm-5m
 for linux-um@lists.infradead.org; Wed, 09 Dec 2020 13:56:10 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v2] um: ubd: Submit all data segments atomically
References: <20201122041356.1454413-1-krisman@collabora.com>
Date: Wed, 09 Dec 2020 10:56:01 -0300
In-Reply-To: <20201122041356.1454413-1-krisman@collabora.com> (Gabriel Krisman
 Bertazi's message of "Sat, 21 Nov 2020 23:13:56 -0500")
Message-ID: <87blf35bim.fsf@collabora.com>
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
To: jdike@addtoit.com
Cc: Martyn Welch <martyn@collabora.com>, richard@nod.at, linux-um@lists.infradead.org, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, anton.ivanov@cambridgegreys.com

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Internally, UBD treats each physical IO segment as a separate command to
> be submitted in the execution pipe.  If the pipe returns a transient
> error after a few segments have already been written, UBD will tell the
> block layer to requeue the request, but there is no way to reclaim the
> segments already submitted.  When a new attempt to dispatch the request
> is done, those segments already submitted will get duplicated, causing
> the WARN_ON below in the best case, and potentially data corruption.

[...]

> Cc: Christopher Obbard <chris.obbard@collabora.com>
> Reported-by: Martyn Welch <martyn@collabora.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

ping. :)

-- 
Gabriel Krisman Bertazi

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

