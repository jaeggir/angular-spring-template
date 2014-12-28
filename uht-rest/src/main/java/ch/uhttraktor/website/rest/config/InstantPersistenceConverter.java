package ch.uhttraktor.website.rest.config;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.sql.Timestamp;
import java.time.Instant;

@Converter(autoApply = true)
public class InstantPersistenceConverter implements AttributeConverter<Instant, Timestamp> {

    @Override
    public Timestamp convertToDatabaseColumn(Instant entityValue) {
        if (entityValue == null) {
            return null;
        }
        return Timestamp.from(entityValue);
    }

    @Override
    public Instant convertToEntityAttribute(Timestamp databaseValue) {
        if (databaseValue == null) {
            return null;
        }
        return databaseValue.toInstant();
    }
}