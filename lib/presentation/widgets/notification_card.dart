import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/providers/notification_provider.dart';
import '../../../data/models/notification_model.dart';

// App theme colors
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final NotificationProvider provider;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: InkWell(
        onTap: () => provider.markAsRead(notification.displayId, context),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image banner
            if (notification.fullImageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: notification.fullImageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and unread indicator
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.displayText,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (!notification.read) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Description
                  if (notification.previewText != null &&
                      notification.previewText!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      notification.displayPreviewText,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],

                  // Date
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      notification.displayDate,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
